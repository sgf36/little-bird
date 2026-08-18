#!/usr/bin/env ruby
# Adds the share extension target to Runner.xcodeproj.
#
#     gem install xcodeproj && ruby ios/add_share_extension.rb
#
# Run on the macOS runner before every build, never committed as a project-file
# change. There is no Mac and no Xcode on the machine this app is written on, and
# hand-editing project.pbxproj is how that file gets quietly corrupted: it is a
# graph with UUID cross-references, not a config file. A tool that understands
# the format does it deterministically, and the diff never has to be reviewed by
# eye.
#
# Idempotent: run it twice and the second run does nothing, so it is safe in a
# workflow that may retry.
require 'xcodeproj'

PROJECT   = 'ios/Runner.xcodeproj'
TARGET    = 'ShareExtension'
BUNDLE_ID = 'com.spencerfields.littlebird.share'
GROUP_DIR = 'ShareExtension'

project = Xcodeproj::Project.open(PROJECT)
app = project.targets.find { |t| t.name == 'Runner' } or abort 'no Runner target'

if project.targets.any? { |t| t.name == TARGET }
  puts "#{TARGET} already present — nothing to do"
  exit 0
end

ext = project.new_target(:app_extension, TARGET, :ios,
                         app.deployment_target, nil, :swift)

group = project.main_group.find_subpath(GROUP_DIR, true)
group.set_source_tree('SOURCE_ROOT')
group.set_path(GROUP_DIR)

source = group.new_reference('ShareViewController.swift')
ext.add_file_references([source])

# The extension is embedded in the app, and the app must be built after it.
app.add_dependency(ext)
embed = app.build_phases.find { |p|
  p.respond_to?(:name) && p.name == 'Embed Foundation Extensions'
} || app.new_copy_files_build_phase('Embed Foundation Extensions')
embed.symbol_dst_subfolder_spec = :plug_ins
build_file = embed.add_file_reference(ext.product_reference)
build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }

# Order matters, and getting it wrong fails with "Cycle inside Runner; building
# could produce unreliable results" rather than anything about ordering.
#
# Flutter's Runner target ends with a "Thin Binary" script phase that processes
# the app binary. A new copy phase is appended after it, so the copy waits on the
# script and the script sees the copy's output inside the bundle it is thinning —
# a cycle. Putting the embed before that script breaks it.
thin = app.build_phases.index do |phase|
  phase.respond_to?(:name) && phase.name.to_s.downcase.include?('thin')
end
if thin
  app.build_phases.delete(embed)
  app.build_phases.insert(thin, embed)
  puts "moved the embed phase before \"#{app.build_phases[thin + 1].name}\""
else
  warn 'no Thin Binary phase found — leaving the embed phase where it is'
end

ext.build_configurations.each do |config|
  s = config.build_settings
  # Without these the product is literally ".appex" — no name — and the build
  # fails with "Multiple commands produce .../.appex", because the target's own
  # product and the copy into the app resolve to the same nameless path. Xcode
  # sets them when you add a target through the interface; new_target does not.
  s['PRODUCT_NAME']              = '$(TARGET_NAME)'
  # Info.plist names the principal class as $(PRODUCT_MODULE_NAME).ShareViewController,
  # so this has to resolve too or the extension loads and finds no class.
  s['PRODUCT_MODULE_NAME']       = TARGET
  s['PRODUCT_BUNDLE_IDENTIFIER'] = BUNDLE_ID
  s['INFOPLIST_FILE']            = "#{GROUP_DIR}/Info.plist"
  s['CODE_SIGN_ENTITLEMENTS']    = "#{GROUP_DIR}/ShareExtension.entitlements"
  s['SWIFT_VERSION']             = '5.0'
  s['IPHONEOS_DEPLOYMENT_TARGET'] = app.build_configurations
                                       .first
                                       .build_settings['IPHONEOS_DEPLOYMENT_TARGET']
  s['TARGETED_DEVICE_FAMILY']    = '1,2'
  s['SKIP_INSTALL']              = 'YES'
  s['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
  # Signing is set by the workflow, which holds the profiles. Left automatic here
  # so a local generation without secrets still opens.
  s['CODE_SIGN_STYLE'] = 'Automatic'
end

project.save
puts "added #{TARGET} (#{BUNDLE_ID}) with deployment target #{app.deployment_target}"
