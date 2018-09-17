<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="shiftSubmission"
      label-width="120px">
      <el-form-item label="希望日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="shiftSubmission.submittedDate"
          type="date"
          placeholder="日付を選択してください"
          value-format="yyyy-MM-dd"
          :picker-options="pickerOptions">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="時刻" required>
        <el-form-item>
          <el-time-select
            placeholder="開始時刻"
            name="shift_submission[start_time]"
            v-model="shiftSubmission.startTime"
            :picker-options="{
              start: team.openTime,
              step: '00:10',
              end: team.closeTime
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item>
          <el-time-select
            placeholder="終了時刻"
            name="shift_submission[end_time]"
            v-model="shiftSubmission.endTime"
            :picker-options="{
              start: team.openTime,
              step: '00:10',
              end: team.closeTime,
              minTime: shiftSubmission.startTime
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
  import { getTeam } from 'api/users/teams.js'
  import { createShiftSubmission } from 'api/users/shift_submissions.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
        pickerOptions: {
          disabledDate(time) {
            return time.getTime() < new Date().getTime() - 3600 * 1000 * 24
          }
        },
        team: {
          id: document.getElementById('shift_submissions_new').dataset.team_id,
          openTime: '',
          closeTime: ''
        },
        member: {
          id: document.getElementById('shift_submissions_new').dataset.member_id
        },
        shiftSubmission: {
          submittedDate: '',
          startTime: '',
          endTime: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        createShiftSubmission(this.member.id, this.shiftSubmission).then((res) => {
          switch (res.status) {
            case 200:
              window.location.href = '/users/members/' + this.member.id
              break;
            case 400:
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created () {
      getTeam(this.team.id).then((res) => {
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
      })
    }
  }
</script>

<style scoped>

</style>
