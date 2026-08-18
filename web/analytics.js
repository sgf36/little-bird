/* Google Analytics 4, consent-gated for UK/EU (PECR + UK GDPR).
 *
 * GA sets cookies and is not strictly necessary, so under PECR it needs the
 * visitor's consent before it runs. Nothing GA-related loads until they accept:
 * Google Consent Mode v2 defaults every storage type to "denied", and only an
 * explicit Accept flips analytics_storage to "granted" and injects the tag.
 * Decline sets no cookies and sends nothing to Google. The choice is remembered
 * in localStorage, so the banner appears once.
 *
 * Ported from the Easy-Post site, which does the same thing, so that both sites
 * behave identically and there is one pattern to reason about rather than two.
 * The measurement ID, the Clarity project id and the storage key differ;
 * nothing else does.
 *
 * This is loaded on every page. It draws its own banner, so pages need only the
 * one <script> tag — no per-page markup and no CSS dependency. The banner is
 * styled to match Wren's palette rather than inheriting the site stylesheet, so
 * it cannot be broken by a change to style.css.
 */
(function () {
  "use strict";

  var GA_ID = "G-EYVRLQBMVF";
  var CLARITY_ID = "y49zevxmw8";
  var KEY = "wren-analytics-consent";

  var choice = null;
  try { choice = localStorage.getItem(KEY); } catch (e) { /* private mode */ }

  window.dataLayer = window.dataLayer || [];
  function gtag() { dataLayer.push(arguments); }

  // Deny everything until the visitor decides.
  gtag("consent", "default", {
    ad_storage: "denied",
    ad_user_data: "denied",
    ad_personalization: "denied",
    analytics_storage: "denied",
  });

  function enableAnalytics() {
    gtag("consent", "update", { analytics_storage: "granted" });
    var s = document.createElement("script");
    s.async = true;
    s.src = "https://www.googletagmanager.com/gtag/js?id=" + GA_ID;
    document.head.appendChild(s);
    gtag("js", new Date());
    gtag("config", GA_ID);
    enableClarity();
    trackConversions();
  }

  /* Microsoft Clarity — heatmaps and session replay. Same shape as the
   * Easy-Post site, and the project id is the only difference.
   *
   * Called only from enableAnalytics(), so it is behind the same consent as
   * GA and nothing reaches Microsoft on a decline. A session recording is not
   * aggregate information and is not information that cannot identify people,
   * so this cannot ride the PECR "statistical purposes" exception the way an
   * aggregate-only tool could. Consent is the only lawful route, so the banner
   * stays for as long as this is here.
   *
   * Empty or PLACEHOLDER disables it cleanly.
   *
   * This is the WEBSITE only. The app carries no analytics of any kind, and
   * the privacy policy and the App Store privacy label both say so — do not
   * let anything here leak into that claim.
   */
  function enableClarity() {
    if (!CLARITY_ID || CLARITY_ID === "PLACEHOLDER") return;
    (function (c, l, a, r, i, t, y) {
      c[a] = c[a] || function () { (c[a].q = c[a].q || []).push(arguments); };
      t = l.createElement(r); t.async = 1;
      t.src = "https://www.clarity.ms/tag/" + i;
      y = l.getElementsByTagName(r)[0]; y.parentNode.insertBefore(t, y);
    })(window, document, "clarity", "script", CLARITY_ID);
  }

  /* Conversion events. Same shape as the Easy-Post site, deliberately.
   *
   * Wren is not on the App Store yet, so there is no purchase funnel to
   * measure. The App Store handler is wired now anyway: the day the link goes
   * on the page it starts counting, with no second deploy and nothing to
   * remember. Until then it simply never matches.
   *
   * Delegated on document, called only from enableAnalytics(), so nothing is
   * sent without consent. Nothing calls preventDefault — GA4 sends by
   * navigator.sendBeacon, which survives the page unloading, so links behave
   * exactly as they did.
   */
  function trackConversions() {
    document.addEventListener("click", function (e) {
      var a = e.target.closest ? e.target.closest("a") : null;
      if (!a) return;

      var href = a.getAttribute("href") || "";

      // The conversion, once there is one to have.
      if (href.indexOf("apps.apple.com") > -1 || href.indexOf("itunes.apple.com") > -1) {
        gtag("event", "app_store_click");
        return;
      }

      if (/^https?:/i.test(href) && href.indexOf(location.host) === -1) {
        gtag("event", "outbound_click", { link_domain: hostOf(href), link_url: href });
      }
    });

    // Support enquiries, caught at submit because the form posts to contact.php.
    var form = document.getElementById("contact-form");
    if (form) {
      form.addEventListener("submit", function () {
        gtag("event", "contact_submit");
      });
    }
  }

  function hostOf(url) {
    try { return new URL(url).hostname; } catch (e) { return "unknown"; }
  }

  function remember(value) {
    try { localStorage.setItem(KEY, value); } catch (e) { /* private mode */ }
  }

  if (choice === "granted") { enableAnalytics(); return; }
  if (choice === "denied") { return; }

  // No choice yet — offer one.
  function showBanner() {
    if (document.getElementById("wren-cookie-bar")) return;

    var bar = document.createElement("div");
    bar.id = "wren-cookie-bar";
    bar.setAttribute("role", "dialog");
    bar.setAttribute("aria-label", "Cookie choice");
    bar.style.cssText =
      "position:fixed;left:0;right:0;bottom:0;z-index:9999;background:#1E4B45;" +
      "color:#EFEAE0;padding:1rem 1.25rem;border-top:1px solid #2C5B54;" +
      "font:400 .92rem/1.55 -apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;" +
      "display:flex;flex-wrap:wrap;gap:.75rem 1.25rem;align-items:center;" +
      "justify-content:center;box-shadow:0 -2px 14px rgba(0,0,0,.3)";

    var msg = document.createElement("span");
    msg.style.maxWidth = "46rem";
    msg.innerHTML =
      "This site uses Google Analytics and Microsoft Clarity to understand how " +
      "it is used, which includes recording how pages are viewed and clicked. " +
      "Nothing loads unless you accept. See the " +
      '<a href="privacy.html" style="color:#F2C879;text-decoration:underline">' +
      "privacy policy</a>.";

    function button(label, primary) {
      var b = document.createElement("button");
      b.type = "button";
      b.textContent = label;
      b.style.cssText =
        "font:600 .9rem -apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;" +
        "padding:9px 20px;border-radius:6px;cursor:pointer;" +
        (primary
          ? "background:#F2C879;color:#12332F;border:1px solid #F2C879;"
          : "background:transparent;color:#EFEAE0;border:1px solid #2C5B54;");
      return b;
    }

    var accept = button("Accept", true);
    var decline = button("Decline", false);

    accept.addEventListener("click", function () {
      remember("granted");
      enableAnalytics();
      bar.remove();
    });
    decline.addEventListener("click", function () {
      remember("denied");
      bar.remove();
    });

    var actions = document.createElement("span");
    actions.style.cssText = "display:flex;gap:.6rem;flex-wrap:wrap";
    actions.appendChild(accept);
    actions.appendChild(decline);

    bar.appendChild(msg);
    bar.appendChild(actions);
    document.body.appendChild(bar);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", showBanner);
  } else {
    showBanner();
  }
})();
