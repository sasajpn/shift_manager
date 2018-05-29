<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="shiftSubmission"
      label-width="120px">
      <el-form-item label="登録日" required>
        <el-date-picker
          name="shift_submission[submitted_date]"
          v-model="shiftSubmission.submittedDate"
          type="date"
          placeholder="日付を選択してください"
          value-format="yyyy-MM-dd"
          :picker-options="pickerOptions">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="時間" required>
        <el-form-item>
          <el-time-select
            placeholder="開始時間"
            name="shift_submission[shift_adjustment][start_time]"
            v-model="shiftAdjustment.startTime"
            :picker-options="{
              start: team.openTime,
              step: '00:10',
              end: team.closeTime
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item>
          <el-time-select
            placeholder="終了時間"
            name="shift_submission[shift_adjustment][end_time]"
            v-model="shiftAdjustment.endTime"
            :picker-options="{
              start: team.openTime,
              step: '00:10',
              end: team.closeTime,
              minTime: shiftAdjustment.startTime
            }">
          </el-time-select>
        </el-form-item>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { newShiftRegister, createShiftRegister } from 'api/users/shift_registers.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
        pickerOptions: {
          disabledDate(time) {
            return time.getTime() < new Date().getTime() - 3600 * 1000 * 24
          }
        },
        team: {
          openTime: '',
          closeTime: ''
        },
        member: {
          id: document.getElementById('shift_registers_new').dataset.member_id
        },
        shiftSubmission: {
          submittedDate: '',
          startTime: '',
          endTime: ''
        },
        shiftAdjustment: {
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
        createShiftRegister(this.member.id, this.shiftSubmission, this.shiftAdjustment).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/users/shift_coordinators/members/' + this.member.id
              break;
            case '400':
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created () {
      newShiftRegister(this.member.id).then((res) => {
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
        this.shiftSubmission.startTime = res.open_time
        this.shiftSubmission.endTime = res.close_time
      })
    }
  }
</script>

<style scoped>

</style>
