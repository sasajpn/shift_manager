<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="member"
      label-width="140px">
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
        <el-button type="primary" @click="onSubmit">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { getMember, updateMember } from 'api/admins/members.js'
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
        member: {
          id: document.getElementById('members_edit').dataset.member_id,
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
        updateMember(this.member).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/admins/members/' + this.member.id
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
        this.member.role = res.role
        this.member.shiftCoordinator = res.shift_coordinator
        this.member.calendarColor = res.calendar_color
      })
    }
  }
</script>

<style scoped>

</style>
