<template>
  <div>
    <el-form
      :model="form"
      :action="form.action"
      method="patch"
      label-width="120px">
      <csrf></csrf>
      <el-form-item label="調整日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
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
              v-model="form.start_time"
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
              v-model="form.end_time"
              :picker-options="{
                start: shiftSubmission.startTime,
                step: '00:10',
                end: shiftSubmission.endTime,
                minTime: form.startTime
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
  import { getShiftAdjustment } from 'api/admins/shift_adjustments.js'
  import CSRF from 'components/shared/csrf.vue'

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        shiftSubmission: {
          submittedDate: '',
          startTime: '',
          endTime: ''
        },
        form: {
          id: document.getElementById('shift_adjustments_edit').dataset.shift_adjustment_id,
          start_time: '',
          end_time: '',
          action: ''
        }
      }
    },
    created () {
      getShiftAdjustment(this.form.id).then((res) => {
        this.form.start_time = res.shift_adjustment.start_time
        this.form.end_time = res.shift_adjustment.end_time
        this.shiftSubmission.submittedDate = res.shift_submission.submitted_date
        this.shiftSubmission.startTime = res.shift_submission.start_time
        this.shiftSubmission.endTime = res.shift_submission.end_time
      })
      this.form.action = '/admins/shift_adjustments/' + this.form.id
    }
  }
</script>

<style scoped>

</style>
