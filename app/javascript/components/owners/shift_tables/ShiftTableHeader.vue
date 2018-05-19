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
    <div class="fc-center">
    </div>
    <div class="fc-clear"></div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        currentDate: this.moment(),
        formattedDate: ''
      }
    },
    methods: {
      moment() {
        return moment()
      },
      addDate() {
        this.currentDate.add(1, 'days')
        this.formattedDate = this.currentDate.format('YYYY年MM月DD日')
      },
      subtractDate() {
        this.currentDate.subtract(1, 'days')
        this.formattedDate = this.currentDate.format('YYYY年MM月DD日')
      },
      returnToday() {
        this.currentDate = this.moment()
        this.formattedDate = this.currentDate.format('YYYY年MM月DD日')
      },
      isToday() {
        return this.formattedDate === this.moment().format('YYYY年MM月DD日')
      }
    },
    created() {
      this.formattedDate = this.currentDate.format('YYYY年MM月DD日')
    }
  }

</script>
