<template>
  <div>
    <el-form
      :model="shiftSubmission"
      label-width="120px">
      <csrf></csrf>
      <el-form-item label="希望日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="shiftSubmission.submitted_date"
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
              v-model="shiftSubmission.start_time"
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
              v-model="shiftSubmission.end_time"
              :picker-options="{
                start: '00:00',
                step: '00:15',
                end: '36:00',
                minTime: shiftSubmission.start_time
              }">
            </el-time-select>
          </el-form-item>
        </el-col>
      </el-form-item>
      <el-form-item>
        <el-button
          @click="onSubmit"
          type="primary">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { edit, update } from 'api/admins/shift_submissions.js'
  import CSRF from 'components/shared/csrf.vue'

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        shiftSubmission: {
          id: document.getElementById('shift_submission_id').value,
          submitted_date: '',
          start_time: '',
          end_time: ''
        }
      }
    },
    methods: {
      onSubmit() {
        let csrf = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        update(this.shiftSubmission.id, this.shiftSubmission, csrf).then((res) => {
        })
      }
    },
    created () {
      edit(this.shiftSubmission.id).then((res) => {
        this.shiftSubmission.submitted_date = res.shift_submission.submitted_date
        this.shiftSubmission.start_time = res.shift_submission.start_time
        this.shiftSubmission.end_time = res.shift_submission.end_time
      })
    }
  }
</script>

<style scoped>

</style>
