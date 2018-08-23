<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="member"
      label-width="140px">
      <el-form-item label="カレンダー表示色" required>
        <el-color-picker
          name="member[calendar_color]"
          v-model="member.calendarColor"
          :predefine="predefineColors">
        </el-color-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { getMember, updateMember } from 'api/users/members.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
        predefineColors: [
          '#ff4500',
          '#ff8c00',
          '#ffd700',
          '#90ee90',
          '#00ced1',
          '#1e90ff',
          '#c71585',
        ],
        team: {
          id: ''
        },
        member: {
          id: document.getElementById('members_edit').dataset.member_id,
          calendarColor: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        updateMember(this.member).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/teams/' + this.team.id
              break;
            case '400':
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created () {
      getMember(this.member.id).then((res) => {
        this.member.calendarColor = res.calendar_color
        this.team.id = res.team_id
      })
    }
  }
</script>

<style scoped>

</style>
