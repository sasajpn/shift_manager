<template>
    <div>
        <error-messages :errorMessages='this.form.errorMessages'></error-messages>
        <el-form
                :model="member"
                label-width="120px">
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
                <el-checkbox v-model="member.shift_coordinator">権限あり</el-checkbox>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="onSubmit">承認</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
  import { getMember } from 'api/owners/members.js'
  import { updateUnapproveMember } from 'api/owners/members/unapprovals.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
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
          id: document.getElementById('members_unapprovals_edit').dataset.member_id,
          role: '',
          shift_coordinator: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        updateUnapproveMember(this.member).then((res) => {
          switch (res.status) {
            case 200:
              window.location.href = '/owners/members/' + this.member.id
              break;
            case 400:
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created () {
      getMember(this.member.id).then((res) => {
        this.member.role = res.role
        this.member.shift_coordinator = res.shift_coordinator
      })
    }
  }
</script>

<style scoped>

</style>
