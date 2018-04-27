<template>
  <div>
    <el-form
      :model="shiftSubmission"
      :action="form.action"
      method="post"
      label-width="120px">
      <input type="hidden" name="_method" value="patch" />
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
                start: '00:00',
                step: '00:10',
                end: '36:00'
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
                start: '00:00',
                step: '00:15',
                end: '36:00',
                minTime: shiftSubmission.startTime
              }">
            </el-time-select>
          </el-form-item>
        </el-col>
      </el-form-item>
      <el-form-item>
        <el-button native-type="submit" type="primary">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { edit } from 'api/admins/shift_submissions.js'
  import CSRF from 'components/shared/csrf.vue'

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        shiftSubmission: {
          id: document.getElementById('shift_submissions_edit').dataset.shift_submission_id,
          submittedDate: '',
          startTime: '',
          endTime: '',
          action: ''
        },
        form: {
          action: ''
        }
      }
    },
    created () {
      edit(this.shiftSubmission.id).then((res) => {
        this.shiftSubmission.submittedDate = res.submitted_date
        this.shiftSubmission.startTime = res.start_time
        this.shiftSubmission.endTime = res.end_time
      })
      this.form.action = '/admins/shift_submissions/' + this.shiftSubmission.id
    }
  }
</script>

<style scoped>

</style>
