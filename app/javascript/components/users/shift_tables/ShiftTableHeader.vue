<template>
  <div class="fc-toolbar fc-header-toolbar">
    <div class="fc-left">
      <h2>{{ formattedDate }}</h2>
    </div>
    <div class="fc-right">
      <el-button-group>
        <el-button type="primary" v-if="isToday()" disabled>今日</el-button>
        <el-button type="primary" v-else v-on:click="returnToday">今日</el-button>
        <el-button type="primary" icon="el-icon-arrow-left" v-on:click="subtractDate"></el-button>
        <el-button type="primary" icon="el-icon-arrow-right" v-on:click="addDate"></el-button>
      </el-button-group>
    </div>
    <div class="fc-clear"></div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters(['currentDate', 'formattedDate'])
    },
    methods: {
      moment() {
        return moment()
      },
      addDate() {
        this.$store.dispatch('updateCurrentDate', this.currentDate.add(1, 'days'))
      },
      subtractDate() {
        this.$store.dispatch('updateCurrentDate', this.currentDate.subtract(1, 'days'))
      },
      returnToday() {
        this.$store.dispatch('updateCurrentDate', this.moment())
      },
      isToday() {
        return this.formattedDate === this.moment().format('YYYY/MM/DD')
      }
    },
    created() {
      this.$store.dispatch('updateCurrentDate', moment())
    }
  }

</script>
