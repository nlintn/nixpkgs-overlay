{ buildMozillaXpiAddon, fetchurl, lib, stdenv }:
  {
    "darkreader" = buildMozillaXpiAddon {
      pname = "darkreader";
      version = "4.9.129";
      addonId = "addon@darkreader.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4899461/darkreader-4.9.129.xpi";
      sha256 = "f4f047fe08e420b6d29617738ea00a7b784892b2262b7e6f38dd09b8ee958a44";
      meta = with lib;
      {
        homepage = "https://darkreader.org/";
        description = "Dark mode for every website. Take care of your eyes, use dark theme for night and daily browsing.";
        license = licenses.mit;
        mozPermissions = [
          "alarms"
          "contextMenus"
          "storage"
          "tabs"
          "theme"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "dictionary-german" = buildMozillaXpiAddon {
      pname = "dictionary-german";
      version = "2.1";
      addonId = "de-DE@dictionaries.addons.mozilla.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4034565/dictionary_german-2.1.xpi";
      sha256 = "00ef6eb3c10171a87fb22ab6e516846678b73c56ae828cc19d11e32e43b8457a";
      meta = with lib;
      {
        description = "German Dictionary (new Orthography) for spellchecking in Firefox";
        license = licenses.lgpl21;
        mozPermissions = [];
        platforms = platforms.all;
      };
    };
    "keepassxc-browser" = buildMozillaXpiAddon {
      pname = "keepassxc-browser";
      version = "1.10.3";
      addonId = "keepassxc-browser@keepassxc.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4831838/keepassxc_browser-1.10.3.xpi";
      sha256 = "4df9c54e0a293aa2e37e9bcf97ec307a35a00e78cebaa9a68edba552c07c4568";
      meta = with lib;
      {
        homepage = "https://keepassxc.org/";
        description = "Official browser plugin for the KeePassXC password manager (https://keepassxc.org).";
        license = licenses.gpl3;
        mozPermissions = [
          "activeTab"
          "clipboardWrite"
          "contextMenus"
          "cookies"
          "nativeMessaging"
          "notifications"
          "storage"
          "tabs"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "https://*/*"
          "http://*/*"
          "https://api.github.com/"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "simplelogin" = buildMozillaXpiAddon {
      pname = "simplelogin";
      version = "3.0.7";
      addonId = "addon@simplelogin";
      url = "https://addons.mozilla.org/firefox/downloads/file/4458602/simplelogin-3.0.7.xpi";
      sha256 = "8e91d0b7e2bc76746818dd8cc533ea525b9c3cfd433fba52da4766a83f579ded";
      meta = with lib;
      {
        homepage = "https://simplelogin.io";
        description = "Create a different email for each website to hide your real email. Guard your inbox against spams, phishing. Protect your privacy.";
        license = licenses.mit;
        mozPermissions = [
          "activeTab"
          "storage"
          "contextMenus"
          "scripting"
          "tabs"
          "http://*/*"
          "https://*/*"
        ];
        platforms = platforms.all;
      };
    };
    "tabwrangler" = buildMozillaXpiAddon {
      pname = "tabwrangler";
      version = "8.3.0";
      addonId = "{81b74d53-9416-4fb3-afa2-ab46684b253b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4785569/tabwrangler-8.3.0.xpi";
      sha256 = "ae2d34c6afe09928ff0b0e68d2f8855805b39de0693ca61c123d35bf98478927";
      meta = with lib;
      {
        homepage = "https://github.com/tabwrangler/tabwrangler/";
        description = "Automatically closes inactive tabs and makes it easy to get them back";
        license = licenses.mit;
        mozPermissions = [
          "alarms"
          "contextMenus"
          "sessions"
          "storage"
          "tabGroups"
          "tabs"
        ];
        platforms = platforms.all;
      };
    };
    "ublock-origin" = buildMozillaXpiAddon {
      pname = "ublock-origin";
      version = "1.74.0";
      addonId = "uBlock0@raymondhill.net";
      url = "https://addons.mozilla.org/firefox/downloads/file/4981431/ublock_origin-1.74.0.xpi";
      sha256 = "175756d74468c9ba45863f7fc333d3be670f82d5b066314e915814dd547d1652";
      meta = with lib;
      {
        homepage = "https://github.com/gorhill/uBlock#ublock-origin";
        description = "Finally, an efficient wide-spectrum content blocker. Easy on CPU and memory.";
        license = licenses.gpl3;
        mozPermissions = [
          "alarms"
          "dns"
          "menus"
          "privacy"
          "storage"
          "tabs"
          "unlimitedStorage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "<all_urls>"
          "http://*/*"
          "https://*/*"
          "file://*/*"
          "https://easylist.to/*"
          "https://*.fanboy.co.nz/*"
          "https://filterlists.com/*"
          "https://forums.lanik.us/*"
          "https://github.com/*"
          "https://*.github.io/*"
          "https://github.com/uBlockOrigin/*"
          "https://ublockorigin.github.io/*"
          "https://*.reddit.com/r/uBlockOrigin/*"
        ];
        platforms = platforms.all;
      };
    };
    "vicinae" = buildMozillaXpiAddon {
      pname = "vicinae";
      version = "1.0.0";
      addonId = "firefox@vicinae.com";
      url = "https://addons.mozilla.org/firefox/downloads/file/4839406/vicinae-1.0.0.xpi";
      sha256 = "996c056d556be9c9c97494403672463117973e7d1bfc10fad9f719f8c07d9426";
      meta = with lib;
      {
        homepage = "https://vicinae.com";
        description = "Connects to the Vicinae desktop app to search and switch browser tabs from the launcher.";
        license = licenses.mit;
        mozPermissions = [ "nativeMessaging" "tabs" ];
        platforms = platforms.all;
      };
    };
    "video-downloadhelper" = buildMozillaXpiAddon {
      pname = "video-downloadhelper";
      version = "10.5.35.2";
      addonId = "{b9db16a4-6edc-47ec-a1f4-b86292ed211d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4963802/video_downloadhelper-10.5.35.2.xpi";
      sha256 = "f29ff5649c3e7eb4c27854160e4ee0312f432253f456b0ca00be6d46ed5ccd55";
      meta = with lib;
      {
        homepage = "https://www.downloadhelper.net/";
        description = "Download videos from the web. Easy, smart, no tracking.";
        mozPermissions = [
          "tabs"
          "downloads"
          "webRequest"
          "webNavigation"
          "scripting"
          "declarativeNetRequest"
          "storage"
          "notifications"
          "contextMenus"
          "unlimitedStorage"
          "*://*.youtube.com/*"
          "*://*.vimeo.com/*"
          "*://*.facebook.com/*"
          "*://*.instagram.com/*"
          "*://*.ok.ru/*"
          "*://*.m.ok.ru/*"
          "*://*.vk.com/*"
          "*://*.vk.ru/*"
          "*://*.vkvideo.ru/*"
          "*://live.vkvideo.ru/*"
          "*://*.canva.com/*"
          "*://*.iq.com/*"
          "*://*.twitcasting.tv/*"
          "*://*.bilibili.tv/*"
          "*://*.bilibili.com/*"
          "*://*.taiav.com/*"
          "*://*.osmosis.org/*"
          "*://*.kick.com/*"
          "*://*.chaturbate.com/*"
          "*://*.chaturbate.eu/*"
          "*://*.chaturbate.global/*"
          "*://*.91porna.com/*"
          "*://*.9n6gyt.umydsfs.cc/*"
          "https://downloadhelper.net/activate*"
          "https://app.downloadhelper.net/activate*"
          "https://v10.downloadhelper.net/activate*"
        ];
        platforms = platforms.all;
      };
    };
    "vimium-ff" = buildMozillaXpiAddon {
      pname = "vimium-ff";
      version = "2.4.2";
      addonId = "{d7742d87-e61d-4b78-b8a1-b469842139fa}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4717567/vimium_ff-2.4.2.xpi";
      sha256 = "131e2a67580e7ae9125ab19781159e61409fac47b441fc2782aab76396ead196";
      meta = with lib;
      {
        homepage = "https://github.com/philc/vimium";
        description = "The Hacker's Browser. Vimium provides keyboard shortcuts for navigation and control in the spirit of Vim.";
        license = licenses.mit;
        mozPermissions = [
          "tabs"
          "bookmarks"
          "history"
          "storage"
          "sessions"
          "notifications"
          "scripting"
          "webNavigation"
          "search"
          "clipboardRead"
          "clipboardWrite"
          "<all_urls>"
          "file:///"
          "file:///*/"
        ];
        platforms = platforms.all;
      };
    };
    "violentmonkey" = buildMozillaXpiAddon {
      pname = "violentmonkey";
      version = "2.48.0";
      addonId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4963965/violentmonkey-2.48.0.xpi";
      sha256 = "e73e3103697cbeee3335020c31c7e3c587946929740cd78f9bff1b50bf62be34";
      meta = with lib;
      {
        homepage = "https://violentmonkey.github.io/";
        description = "Userscript support for browsers, open source.";
        license = licenses.mit;
        mozPermissions = [
          "tabs"
          "<all_urls>"
          "webRequest"
          "webRequestBlocking"
          "notifications"
          "storage"
          "unlimitedStorage"
          "clipboardWrite"
          "contextMenus"
          "cookies"
        ];
        platforms = platforms.all;
      };
    };
    "zen-internet" = buildMozillaXpiAddon {
      pname = "zen-internet";
      version = "3.2.0";
      addonId = "{91aa3897-2634-4a8a-9092-279db23a7689}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4854703/zen_internet-3.2.0.xpi";
      sha256 = "78410e877277913f19bdcdf8ca138e08dff758fd8b9ed99d67c52681e581fd19";
      meta = with lib;
      {
        homepage = "https://www.sameerasw.com";
        description = "Inject custom css to make the web beautiful in Zen Browser";
        license = licenses.mit;
        mozPermissions = [
          "activeTab"
          "storage"
          "tabs"
          "webNavigation"
          "alarms"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
  }