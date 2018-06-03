<template>
  <shift-adjustments-form v-on:onSubmit="onSubmit"></shift-adjustments-form>
</template>

<script>
  import shiftAdjustmentsForm from 'components/users/shift_adjustments/Form.vue'
  import { createShiftAdjustment } from 'api/users/shift_adjustments.js'

  export default {
    components: {
      shiftAdjustmentsForm
    },
    methods: {
      onSubmit(shiftSubmissionId, shiftAdjustment) {
        createShiftAdjustment(shiftSubmissionId, shiftAdjustment).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/part_timers/shift_submissions/' + shiftSubmissionId
              break;
            case '400':
              this.$store.dispatch('setErrorMessages', res.error_messages)
              break;
          }
        })
      }
    },
  }
</script>

<style scoped>

</style>
