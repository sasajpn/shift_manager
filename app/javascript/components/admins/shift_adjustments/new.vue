<template>
  <div>
    <el-form
      :model="form"
      :action="form.action"
      method="post"
      label-width="120px">
      <csrf></csrf>
      <el-form-item label="希望日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="form.submittedDate"
          type="date"
          placeholder="日付を選択してください">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="時刻" required>
        <el-col :span="11">
          <el-form-item>
            <el-time-select
              placeholder="開始時刻"
              name="shift_adjustment[start_time]"
              v-model="form.startTime"
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
              name="shift_adjustment[end_time]"
              v-model="form.endTime"
              :picker-options="{
                start: '00:00',
                step: '00:15',
                end: '36:00',
                minTime: form.startTime
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
  import CSRF from 'components/shared/csrf.vue';

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        form: {
          shift_submission_id: document.getElementById('shift_adjustments_new').dataset.shift_submission_id,
          submittedDate: '',
          startTime: '',
          endTime: '',
          action: ''
        }
      }
    },
    created () {
      this.form.action = '/admins/shift_submissions/' + this.form.shift_submission_id + '/shift_adjustments'
  }
</script>

<style scoped>

</style>
