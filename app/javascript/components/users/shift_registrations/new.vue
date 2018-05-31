<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="shiftRegistration"
      label-width="120px">
      <el-form-item label="登録日" required>
        <el-date-picker
          name="shift_registration[registered_date]"
          v-model="shiftRegistration.registeredDate"
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
            name="shift_registration[start_time]"
            v-model="shiftRegistration.startTime"
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
            name="shift_registration[end_time]"
            v-model="shiftRegistration.endTime"
            :picker-options="{
              start: team.openTime,
              step: '00:10',
              end: team.closeTime,
              minTime: shiftRegistration.startTime
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
  import { newShiftRegistration, createShiftRegistration } from 'api/users/shift_registrations.js'
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
          id: document.getElementById('shift_registrations_new').dataset.member_id
        },
        shiftRegistration: {
          registeredDate: '',
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
        createShiftRegistration(this.member.id, this.shiftRegistration).then((res) => {
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
      newShiftRegistration(this.member.id).then((res) => {
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
      })
    }
  }
</script>

<style scoped>

</style>
