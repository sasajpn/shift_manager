/* eslint no-console:0 */

import Vue from 'vue/dist/vue.esm'

import * as _ from 'lodash'

import ElementUI from 'element-ui'

import locale from 'element-ui/lib/locale/lang/ja'

const library = {
  Vue: Vue,
  '_': _,
  ElementUI: ElementUI,
  locale: locale
}

_.each(library, (plugin, namespace) => {
  window[namespace] = plugin
})
