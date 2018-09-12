<template>
  <div>
    <error-messages :errorMessages='this.errorMessages'></error-messages>
    <el-form
      label-width="120px">
      <el-form-item label="登録日" required>
        <el-date-picker
          name="shift_registration[registered_date]"
          v-model="registeredDate"
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
            v-model="startTime"
            :picker-options="{
              start: teamOpenTime,
              step: '00:10',
              end: teamCloseTime
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item>
          <el-time-select
            placeholder="終了時間"
            name="shift_registration[end_time]"
            v-model="endTime"
            :picker-options="{
              start: teamOpenTime,
              step: '00:10',
              end: teamCloseTime,
              minTime: startTime
            }">
          </el-time-select>
        </el-form-item>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">{{ btnName }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import ErrorMessages from 'components/shared/error_messages.vue'
  import { mapState } from 'vuex'

  export default {
    components: {
      ErrorMessages
    },
    props: {
      btnName: String
    },
    computed: {
      ...mapState({
        teamOpenTime: state => state.Team.openTime,
        teamCloseTime: state => state.Team.closeTime,
        errorMessages: state => state.ShiftRegistration.errorMessages
      }),
      registeredDate: {
        get () {
          return this.$store.state.ShiftRegistration.registeredDate
        },
        set (value) {
          this.$store.dispatch('ShiftRegistration/updateRegisteredDate', value)
        }
      },
      startTime: {
        get () {
          return this.$store.state.ShiftRegistration.startTime
        },
        set (value) {
          this.$store.dispatch('ShiftRegistration/updateStartTime', value)
        }
      },
      endTime: {
        get () {
          return this.$store.state.ShiftRegistration.endTime
        },
        set (value) {
          this.$store.dispatch('ShiftRegistration/updateEndTime', value)
        }
      }
    },
    data() {
      return {
        pickerOptions: {
          disabledDate(time) {
            return time.getTime() < new Date().getTime() - 3600 * 1000 * 24
          }
        }
      }
    },
    methods: {
      onSubmit() {
        this.$emit('onSubmit', this.$store.state.Member.id, this.$store.state.ShiftRegistration)
      },
    }
  }
</script>

<style scoped>

</style>
