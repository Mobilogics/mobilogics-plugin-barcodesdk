cordova.define("tw.com.mobilogics.sdk.barcode.plugins.phonegap.MobilogicsScanner", function(require, exports, module) {
/*
 * Licensed to Creative Commons Attribution-ShareAlike 4.0
 * International. Please see the LICENSE.pdf.
 * You may obtain a copy of the License at
 *
 * http://creativecommons.org/licenses/by-sa/4.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */
var argscheck = require('cordova/argscheck'),
    channel = require('cordova/channel'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec'),
    cordova = require('cordova');

channel.createSticky('onCordovaInfoReady');
// Tell cordova channel to wait on the CordovaInfoReady event
channel.waitForInitialization('onCordovaInfoReady');

/**
 * Constructor
 **/
function MobilogicsScanner () {
  this.available = false;
  var me = this;

  channel.onCordovaReady.subscribe(function() {
    me.start(function(info) {
               me.available = true;
               channel.onCordovaInfoReady.fire();
             },function(e) {
               me.available = false;
               utils.alert("[ERROR] Error initializing Cordova: " + e);
             });
  });
}

MobilogicsScanner.prototype.start = function(successCallback, errorCallback) {
               //  argscheck.checkArgs('fF', 'MobilogicsScanner.start', arguments);
  exec(successCallback, errorCallback, "MobilogicsScanner", "start", []);
};

MobilogicsScanner.prototype.scan = function(successCallback, errorCallback) {
  exec(successCallback, errorCallback, "MobilogicsScanner", "scan", []);
};

MobilogicsScanner.prototype.monitor = function(successCallback, errorCallback) {
  exec(successCallback, errorCallback, "MobilogicsScanner", "monitorConnection", []);
};

module.exports = new MobilogicsScanner();
});
