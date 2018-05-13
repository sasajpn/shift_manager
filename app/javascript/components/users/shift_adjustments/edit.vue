<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="shiftAdjustment"
      label-width="120px">
      <el-form-item label="調整日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="shiftSubmission.submittedDate"
          type="date"
          placeholder="日付を選択してください"
          value-format="yyyy-MM-dd"
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
        <el-button type="primary" @click="onSubmit">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { editShiftAdjustment, updateShiftAdjustment } from 'api/users/shift_adjustments.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
        shiftSubmission: {
          id: '',
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
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        updateShiftAdjustment(this.shiftAdjustment).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/shift_submissions/' + this.shiftSubmission.id
              break;
            case '400':
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created () {
      editShiftAdjustment(this.shiftAdjustment.id).then((res) => {
        this.shiftAdjustment.startTime = res.shift_adjustment.start_time
        this.shiftAdjustment.endTime = res.shift_adjustment.end_time
        this.shiftSubmission.id = res.shift_submission.id
        this.shiftSubmission.submittedDate = res.shift_submission.submitted_date
        this.shiftSubmission.startTime = res.shift_submission.start_time
        this.shiftSubmission.endTime = res.shift_submission.end_time
      })
    }
  }
</script>

<style scoped>

</style>
