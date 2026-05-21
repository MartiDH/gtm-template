___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___
{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "displayName": "Bot Shield Sensor",
  "categories": ["SECURITY", "UTILITY"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "Bot Shield"
  },
  "description": "Deploy the Bot Shield click-fraud detection sensor with sandboxed Google validation.",
  "containerContexts": [
    "WEB"
  ]
}

___TEMPLATE_PARAMETERS___
[
  {
    "type": "TEXT",
    "name": "endpoint",
    "displayName": "API Endpoint URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Your Bot Shield API instance URL (e.g., https://hamstershield.digitalhamster.com)"
  },
  {
    "type": "TEXT",
    "name": "apiKey",
    "displayName": "Sensor API Key",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Your site-specific SENSOR_API_KEY from Bot Shield settings."
  },
  {
    "type": "TEXT",
    "name": "siteId",
    "displayName": "Site ID / Client Slug",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "The client identifier registered in Bot Shield (e.g., GeneralOptica)"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___
const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const log = require('logToConsole');

const endpoint = data.endpoint;
const apiKey = data.apiKey;
const siteId = data.siteId;

if (!endpoint || !apiKey) {
  log('Error: API Endpoint and API Key are required.');
  data.gtmOnFailure();
} else {
  // Set global variables on the window object so sensor.js can read them.
  setInWindow('BS_ENDPOINT', endpoint, true);
  setInWindow('BS_KEY', apiKey, true);
  setInWindow('BS_SITE', siteId || '', true);

  // Construct URL to sensor.js served by the FastAPI backend.
  let cleanEndpoint = endpoint;
  while (cleanEndpoint && cleanEndpoint.charAt(cleanEndpoint.length - 1) === '/') {
    cleanEndpoint = cleanEndpoint.substring(0, cleanEndpoint.length - 1);
  }
  const sensorUrl = cleanEndpoint + '/sensor.js';

  // Inject the sensor script
  injectScript(sensorUrl, () => {
    data.gtmOnSuccess();
  }, () => {
    log('Error: Failed to load Bot Shield sensor script from ' + sensorUrl);
    data.gtmOnFailure();
  }, 'botshield_sensor');
}

___WEB_PERMISSIONS___
[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://*.digitalhamster.com/*"
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "BS_ENDPOINT"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "BS_KEY"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "BS_SITE"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  }
]

___RESETS___
{
  "value": []
}

___TESTS___
___NOTES___
