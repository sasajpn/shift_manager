<template>
  <shift-registration-form v-on:onSubmit="onSubmit" :btnName="btnName"></shift-registration-form>
</template>

<script>
  import shiftRegistrationForm from 'components/users/shift_registrations/Form.vue'
  import { updateShiftRegistration } from 'api/users/shift_registrations.js'

  export default {
    components: {
      shiftRegistrationForm
    },
    data() {
      return {
        btnName: '更新'
      }
    },
    methods: {
      onSubmit(memberId, shiftRegistration) {
        updateShiftRegistration(shiftRegistration).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/managers/members/' + memberId
              break;
            case '400':
              this.$store.dispatch('ShiftRegistration/setErrorMessages', res.error_messages)
              break;
          }
        })
      }
    },
    created () {
      let teamId = document.getElementById('shift_registrations_edit').dataset.team_id
      let shiftRegistrationId = document.getElementById('shift_registrations_edit').dataset.shift_registration_id
      let memberId = document.getElementById('shift_registrations_edit').dataset.member_id
      this.$store.dispatch('Team/loadTeam', teamId)
      this.$store.dispatch('ShiftRegistration/loadShiftRegistration', shiftRegistrationId)
      this.$store.dispatch('Member/updateId', memberId)
    }
  }
</script>

<style scoped>

</style>
