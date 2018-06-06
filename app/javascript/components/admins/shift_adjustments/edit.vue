<template>
  <div>
    <el-form
      :model="shiftAdjustment"
      :action="form.action"
      method="post"
      label-width="120px">
      <input type="hidden" name="_method" value="patch" />
      <csrf></csrf>
      <el-form-item label="調整日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="shiftSubmission.submittedDate"
          type="date"
          value-format="yyyy-MM-dd"
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
        <el-button native-type="submit" type="primary">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { editShiftAdjustment } from 'api/admins/shift_adjustments.js'
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
        shiftAdjustment: {
          id: document.getElementById('shift_adjustments_edit').dataset.shift_adjustment_id,
          startTime: '',
          endTime: '',
        },
        form: {
          action: ''
        }
      }
    },
    created () {
      editShiftAdjustment(this.shiftAdjustment.id).then((res) => {
        this.shiftAdjustment.startTime = res.shift_adjustment.start_time
        this.shiftAdjustment.endTime = res.shift_adjustment.end_time
        this.shiftSubmission.submittedDate = res.shift_submission.submitted_date
        this.shiftSubmission.startTime = res.shift_submission.start_time
        this.shiftSubmission.endTime = res.shift_submission.end_time
      })
      this.form.action = '/admins/shift_adjustments/' + this.shiftAdjustment.id
    }
  }
</script>

<style scoped>

</style>
