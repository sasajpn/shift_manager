<template>
  <div class="alert alert-danger" v-if="errorMessages.length > 0">
    <p>以下のエラー内容を修正してください</p>
    <ul class="rails-bootstrap-forms-error-summary">
      <li v-for="errorMessage in errorMessages">{{ errorMessage }}</li>
    </ul>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  export default {
    computed: {
      ...mapGetters(['errorMessages'])
    }
  }
</script>
