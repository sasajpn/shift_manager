<template>
  <div>
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
          placeholder="日付を選択してください"
          value-format="yyyy-MM-dd">
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
  import { newShiftSubmission } from 'api/admins/shift_submissions.js'
  import CSRF from 'components/shared/csrf.vue'

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        team: {
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
          action: ''
        }
      }
    },
    created () {
      newShiftSubmission(this.member.id).then((res) => {
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
      })
      this.form.action = '/admins/members/' + this.member.id + '/shift_submissions'
    }
  }
</script>

<style scoped>

</style>
