<template>
  <shift-adjustments-form v-on:onSubmit="onSubmit" :btnName="btnName"></shift-adjustments-form>
</template>

<script>
  import shiftAdjustmentsForm from 'components/users/shift_adjustments/Form.vue'
  import { updateShiftAdjustment } from 'api/users/shift_adjustments.js'

  export default {
    components: {
      shiftAdjustmentsForm
    },
    data() {
      return {
        btnName: '更新'
      }
    },
    methods: {
      onSubmit(shiftSubmissionId, shiftAdjustment) {
        updateShiftAdjustment(shiftAdjustment).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/full_timers/shift_submissions/' + shiftSubmissionId
              break;
            case '400':
              this.$store.dispatch('ShiftAdjustment/setErrorMessages', res.error_messages)
              break;
          }
        })
      }
    },
    created () {
      let shiftSubmissionId = document.getElementById('shift_adjustments_edit').dataset.shift_submission_id
      let shiftAdjustmentId = document.getElementById('shift_adjustments_edit').dataset.shift_adjustment_id
      this.$store.dispatch('ShiftSubmission/loadShiftSubmission', shiftSubmissionId)
      this.$store.dispatch('ShiftAdjustment/loadShiftAdjustment', shiftAdjustmentId)
    }
  }
</script>

<style scoped>

</style>
