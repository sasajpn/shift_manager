<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="joinTeamForm"
      label-width="140px">
      <el-form-item label="認証コード" required>
        <el-input
          name="join_team_form[identifier]"
          v-model="joinTeamForm.identifier"
          placeholder="認証コードを入力してください"></el-input>
      </el-form-item>
      <el-form-item label="カレンダー表示色" required>
        <el-color-picker
          name="join_team_form[calendar_color]"
          v-model="joinTeamForm.calendarColor"
          :predefine="predefineColors">
        </el-color-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">参加する</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { createUnapprovalMember } from 'api/users/members/unapprovals.js'
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
        joinTeamForm: {
          identifier: '',
          calendarColor: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        createUnapprovalMember(this.joinTeamForm).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/members/unapprovals'
              break;
            case '400':
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    }
  }
</script>

<style scoped>

</style>
