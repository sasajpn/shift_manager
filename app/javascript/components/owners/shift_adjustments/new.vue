<template>
  <shift-adjustments-form v-on:onSubmit="onSubmit" :btnName="btnName"></shift-adjustments-form>
</template>

<script>
  import shiftAdjustmentsForm from 'components/owners/shift_adjustments/Form.vue'
  import { createShiftAdjustment } from 'api/owners/shift_adjustments.js'

  export default {
    components: {
      shiftAdjustmentsForm
    },
    data() {
      return {
        btnName: '登録'
      }
    },
    methods: {
      onSubmit(shiftSubmissionId, shiftAdjustment) {
        createShiftAdjustment(shiftSubmissionId, shiftAdjustment).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/owners/shift_submissions/' + shiftSubmissionId
              break;
            case '400':
              this.$store.dispatch('ShiftAdjustment/setErrorMessages', res.error_messages)
              break;
          }
        })
      }
    },
    created () {
      let shiftSubmissionId = document.getElementById('shift_adjustments_new').dataset.shift_submission_id
      this.$store.dispatch('ShiftSubmission/loadShiftSubmission', shiftSubmissionId)
    }
  }
</script>

<style scoped>

</style>
