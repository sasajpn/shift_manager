<template>
  <div>
    <el-form
      :model="form"
      method="patch"
      :action="form.action"
      label-width="120px">
      <csrf></csrf>
      <el-form-item label="希望日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="form.submitted_date"
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
              v-model="form.start_time"
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
              v-model="form.end_time"
              :picker-options="{
                start: '00:00',
                step: '00:15',
                end: '36:00',
                minTime: form.start_time
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
        form: {
          id: document.getElementById('shift_submissions_edit').dataset.shift_submission_id,
          submitted_date: '',
          start_time: '',
          end_time: '',
          action: ''
        }
      }
    },
    created () {
      edit(this.form.id).then((res) => {
        this.form.submitted_date = res.submitted_date
        this.form.start_time = res.start_time
        this.form.end_time = res.end_time
        this.form.action = '/admins/shift_submissions/' + this.form.id
      })
    }
  }
</script>

<style scoped>

</style>
