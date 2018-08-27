<template>
  <div>
    <error-messages :errorMessages='this.errorMessages'></error-messages>
    <el-form
      label-width="120px">
      <el-form-item label="調整日" required>
        <el-date-picker
          v-model="submissionSubmittedDate"
          type="date"
          value-format="yyyy-MM-dd"
          disabled>
        </el-date-picker>
      </el-form-item>
      <el-form-item label="時刻" required>
        <el-col>
          <el-time-select
            placeholder="開始時刻"
            name="shift_adjustment[start_time]"
            v-model="adjustmentStartTime"
            :picker-options="{
              start: submissionStartTime,
              step: '00:10',
              end: submissionEndTime
            }">
          </el-time-select>
        </el-col>
        <el-col>
          <el-time-select
            placeholder="終了時刻"
            name="shift_adjustment[end_time]"
            v-model="adjustmentEndTime"
            :picker-options="{
              start: submissionStartTime,
              step: '00:10',
              end: submissionEndTime,
              minTime: adjustmentStartTime
            }">
          </el-time-select>
        </el-col>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">{{ btnName }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    props: {
      btnName: String
    },
    computed: {
      ...mapState({
        submissionSubmittedDate: state => state.ShiftSubmission.submittedDate,
        submissionStartTime: state => state.ShiftSubmission.startTime,
        submissionEndTime: state => state.ShiftSubmission.endTime,
        errorMessages: state => state.ShiftAdjustment.errorMessages
      }),
      adjustmentStartTime: {
        get () {
          return this.$store.state.ShiftAdjustment.startTime
        },
        set (value) {
          this.$store.dispatch('ShiftAdjustment/updateStartTime', value)
        }
      },
      adjustmentEndTime: {
        get () {
          return this.$store.state.ShiftAdjustment.endTime
        },
        set (value) {
          this.$store.dispatch('ShiftAdjustment/updateEndTime', value)
        }
      }
    },
    methods: {
      onSubmit() {
        this.$emit('onSubmit', this.$store.state.ShiftSubmission.id, this.$store.state.ShiftAdjustment)
      },
    }
  }
</script>

<style scoped>

</style>
