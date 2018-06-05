<template>
  <shift-registration-form v-on:onSubmit="onSubmit" :btnName="btnName"></shift-registration-form>
</template>

<script>
  import shiftRegistrationForm from 'components/users/shift_registrations/Form.vue'
  import { createShiftRegistration } from 'api/users/shift_registrations.js'

  export default {
    components: {
      shiftRegistrationForm
    },
    data() {
      return {
        btnName: '登録'
      }
    },
    methods: {
      onSubmit(memberId, shiftRegistration) {
        createShiftRegistration(memberId, shiftRegistration).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/full_timers/members/' + memberId
              break;
            case '400':
              this.$store.dispatch('ShiftRegistration/setErrorMessages', res.error_messages)
              break;
          }
        })
      }
    },
    created () {
      let teamId = document.getElementById('shift_registrations_new').dataset.team_id
      let memberId = document.getElementById('shift_registrations_new').dataset.member_id
      this.$store.dispatch('Team/loadTeam', teamId)
      this.$store.dispatch('Member/updateId', memberId)
    }
  }
</script>

<style scoped>

</style>
