# 🛡️ Bot Shield Custom GTM Template

This is the official Custom Tag Template for deploying the **Bot Shield Click-Fraud Detection Sensor** via Google Tag Manager (GTM).

Deploying the sensor via this Custom Template ensures that the script runs inside Google's secure **JavaScript sandbox** with explicitly declared permissions (`inject_script` and `access_globals`), resolving IT compliance and security objections.

---

## 📋 Features

* **Sandboxed Execution:** Runs securely within GTM's sandbox.
* **Granular Permissions:** Explicitly requests permission only to inject the sensor script and set fallback global variables.
* **No Hardcoded Keys:** Configuration (endpoint, API key, site ID) is passed dynamically per client via GTM fields.

---

## ⚙️ Configuration Parameters

When you add the **Bot Shield Sensor** tag in GTM, configure the following fields:

1. **API Endpoint URL:** Your Bot Shield instance API endpoint (e.g., `https://hamstershield.yourdomain.com`).
2. **Sensor API Key:** The site-specific `SENSOR_API_KEY` registered in your Bot Shield instance.
3. **Site ID / Client Slug:** The unique client identifier registered in Bot Shield.

---

## 🚀 Installation & Deployment

### Method A: Search in the Community Template Gallery

1. In Google Tag Manager, navigate to **Templates** -> **Tag Templates** -> **Search Gallery**.
2. Search for **Bot Shield Sensor**.
3. Click **Add to workspace**.

### Method B: Manual Import (Developer / Testing)

1. Download the `template.tpl` file from this repository.
2. In GTM, navigate to **Templates** -> **Tag Templates** -> **New**.
3. Click the three dots (⋮) in the top-right corner and select **Import**.
4. Choose the `template.tpl` file and click **Save**.

---

## 🔒 Permissions & Safety

This template utilizes GTM's modern APIs to ensure safety:
* `injectScript`: Injects `sensor.js` dynamically from the specified secure endpoint.
* `setInWindow`: Securely declares the endpoint, API key, and site slug variables globally inside the page context so the sensor script can read them.

---

## 📄 License

This template is licensed under the Apache License 2.0. See the `LICENSE` file for details.
