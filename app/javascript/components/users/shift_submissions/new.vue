<template>
  <div>
    <div class="alert alert-danger" v-if="this.form.errors[0] !== ''">
      <p>以下のエラー内容を修正してください</p>
      <ul class="rails-bootstrap-forms-error-summary">
        <li v-for="error in this.form.errors">{{ error }}</li>
      </ul>
    </div>
    <el-form
      :model="shiftSubmission"
      :action="form.action"
      method="post"
      label-width="120px">
      <csrf></csrf>
      <el-form-item label="希望日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="shiftSubmission.submittedDate"
          type="date"
          placeholder="日付を選択してください">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="時刻" required>
        <el-col :span="11">
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
        </el-col>
        <el-col :span="11">
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
        </el-col>
      </el-form-item>
      <el-form-item>
        <el-button native-type="submit" type="primary">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { newShiftSubmission } from 'api/users/shift_submissions.js'
  import CSRF from 'components/shared/csrf.vue'

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        team: {
          id: document.getElementById('shift_submissions_new').dataset.team_id,
          openTime: '',
          closeTime: ''
        },
        shiftSubmission: {
          submittedDate: '',
          startTime: '',
          endTime: ''
        },
        form: {
          action: '',
          errors: []
        }
      }
    },
    created () {
      newShiftSubmission(this.team.id).then((res) => {
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
      })
      this.form.action = '/users/teams/' + this.team.id + '/shift_submissions'
      this.form.errors = document.getElementById('shift_submissions_new').dataset.error_messages.split(',')
    }
  }
</script>

<style scoped>

</style>
