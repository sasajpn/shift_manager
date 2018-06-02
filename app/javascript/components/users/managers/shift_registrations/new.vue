<template>
  <shift-registration-form v-on:onSubmit="onSubmit"></shift-registration-form>
</template>

<script>
  import shiftRegistrationForm from 'components/users/shift_registrations/Form.vue'
  import { createShiftRegistration } from 'api/users/shift_registrations.js'

  export default {
    components: {
      shiftRegistrationForm
    },
    methods: {
      onSubmit(memberId, shiftRegistration) {
        createShiftRegistration(memberId, shiftRegistration).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/managers/members/' + memberId
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
