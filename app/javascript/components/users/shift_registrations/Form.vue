<template>
  <div>
    <error-messages></error-messages>
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
              start: openTime,
              step: '00:10',
              end: closeTime
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item>
          <el-time-select
            placeholder="終了時間"
            name="shift_registration[end_time]"
            v-model="endTime"
            :picker-options="{
              start: openTime,
              step: '00:10',
              end: closeTime,
              minTime: startTime
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
  import ErrorMessages from 'components/shared/error_messages.vue'
  import { mapGetters } from 'vuex'

  export default {
    components: {
      ErrorMessages
    },
    computed: {
      ...mapGetters(['openTime', 'closeTime']),
      registeredDate: {
        get () {
          return this.$store.state.ShiftRegistration.registeredDate
        },
        set (value) {
          this.$store.dispatch('updateRegisteredDate', value)
        }
      },
      startTime: {
        get () {
          return this.$store.state.ShiftRegistration.startTime
        },
        set (value) {
          this.$store.dispatch('updateStartTime', value)
        }
      },
      endTime: {
        get () {
          return this.$store.state.ShiftRegistration.endTime
        },
        set (value) {
          this.$store.dispatch('updateEndTime', value)
        }
      }
    },
    data() {
      return {
        pickerOptions: {
          disabledDate(time) {
            return time.getTime() < new Date().getTime() - 3600 * 1000 * 24
          }
        },
        team: {
          id: document.getElementById('shift_registrations_new').dataset.team_id
        },
        member: {
          id: document.getElementById('shift_registrations_new').dataset.member_id
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        this.$emit('onSubmit', this.member.id, this.$store.state.ShiftRegistration)
      },
    },
    created () {
      this.$store.dispatch('loadTeam', this.team.id)
    }
  }
</script>

<style scoped>

</style>
