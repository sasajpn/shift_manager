<template>
  <div>
    <el-form
      :model="shiftAdjustment"
      :action="form.action"
      method="post"
      label-width="120px">
      <csrf></csrf>
      <el-form-item label="調整日" required>
        <el-date-picker
          v-model="shiftSubmission.submittedDate"
          type="date"
          placeholder="日付を選択してください"
          disabled>
        </el-date-picker>
      </el-form-item>
      <el-form-item label="時刻" required>
        <el-col :span="11">
          <el-form-item>
            <el-time-select
              placeholder="開始時刻"
              name="shift_adjustment[start_time]"
              v-model="shiftAdjustment.startTime"
              :picker-options="{
                start: shiftSubmission.startTime,
                step: '00:10',
                end: shiftSubmission.endTime
              }">
            </el-time-select>
          </el-form-item>
        </el-col>
        <el-col :span="11">
          <el-form-item>
            <el-time-select
              placeholder="終了時刻"
              name="shift_adjustment[end_time]"
              v-model="shiftAdjustment.endTime"
              :picker-options="{
                start: shiftSubmission.startTime,
                step: '00:10',
                end: shiftSubmission.endTime,
                minTime: shiftAdjustment.startTime
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
  import { newShiftAdjustment } from 'api/users/shift_adjustments.js'
  import CSRF from 'components/shared/csrf.vue'

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        shiftSubmission: {
          id: document.getElementById('shift_adjustments_new').dataset.shift_submission_id,
          submittedDate: '',
          startTime: '',
          endTime: ''
        },
        shiftAdjustment: {
          startTime: '',
          endTime: ''
        },
        form: {
          action: ''
        }
      }
    },
    created () {
      newShiftAdjustment(this.shiftSubmission.id).then((res) => {
        this.shiftSubmission.submittedDate = res.submitted_date
        this.shiftSubmission.startTime = res.start_time
        this.shiftSubmission.endTime = res.end_time
      })
      this.form.action = '/users/shift_submissions/' + this.shiftSubmission.id + '/shift_adjustments'
    }
  }
</script>

<style scoped>

</style>
