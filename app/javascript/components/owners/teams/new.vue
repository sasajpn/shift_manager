<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="team"
      label-width="120px">
      <el-form-item label="会社名" required>
        <el-input
          name="team[name]"
          v-model="team.name"
          placeholder="会社名を入力してください">
        </el-input>
      </el-form-item>
      <el-form-item label="営業時間">
        <el-form-item label="開始時間" required>
          <el-time-select
            placeholder="開始時間"
            name="team[open_time]"
            v-model="team.openTime"
            :picker-options="{
              start: '00:00',
              step: '00:10',
              end: '36:00'
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item label="終了時間" required>
          <el-time-select
            placeholder="終了時刻"
            name="team[close_time]"
            v-model="team.closeTime"
            :picker-options="{
              start: '00:00',
              step: '00:10',
              end: '36:00',
              minTime: team.openTime
            }">
          </el-time-select>
        </el-form-item>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { createTeam } from 'api/owners/teams.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
        team: {
          name: '',
          openTime: '',
          endTime: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        createTeam(this.team).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/owners/teams'
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
