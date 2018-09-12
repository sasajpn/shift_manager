<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="member"
      label-width="140px">
      <el-form-item label="ユーザ" required>
        <el-select v-model="member.userId" placeholder="ユーザを選択してください">
          <el-option
            v-for="user in users"
            :key="user.id"
            :label="user.email"
            :value="user.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="役職" required>
        <el-select v-model="member.role" placeholder="役職を選択してください">
          <el-option
            v-for="role in roles"
            :key="role.value"
            :label="role.label"
            :value="role.value">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="シフト調整" v-if="member.role != 'manager'">
        <el-checkbox v-model="member.shiftCoordinator">権限あり</el-checkbox>
      </el-form-item>
      <el-form-item label="カレンダー表示色" required>
        <el-color-picker
          v-model="member.calendarColor"
          :predefine="predefineColors">
        </el-color-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { getUsers } from 'api/admins/users.js'
  import { createMember } from 'api/admins/members.js'
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
        users: [],
        roles: [
          {
            value: 'part_timer',
            label: 'パートタイマー'
          },
          {
            value: 'full_timer',
            label: '正社員'
          },
          {
            value: 'manager',
            label: '店長'
          }
        ],
        team: {
          id: document.getElementById('members_new').dataset.team_id
        },
        member: {
          userId: '',
          role: '',
          shiftCoordinator: '',
          calendarColor: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        createMember(this.team.id, this.member).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/admins/teams/' + this.team.id
              break;
            case '400':
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created () {
      getUsers().then((res) => {
        this.users = res
      })
    }
  }
</script>

<style scoped>

</style>
