/* eslint no-console:0 */

import Vue from 'vue/dist/vue.esm'

import Vuex from 'vuex'

import * as _ from 'lodash'

import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'

const library = {
  Vue: Vue,
  Vuex: Vuex,
  '_': _,
  ElementUI: ElementUI,
  locale: locale
}

_.each(library, function(plugin, namespace) {
  window[namespace] = plugin
})
