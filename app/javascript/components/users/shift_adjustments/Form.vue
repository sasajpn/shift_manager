<template>
  <div>
    <error-messages></error-messages>
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
        <el-col :span="11">
          <el-form-item>
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
          </el-form-item>
        </el-col>
        <el-col :span="11">
          <el-form-item>
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
          </el-form-item>
        </el-col>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    computed: {
      ...mapGetters(['submissionSubmittedDate', 'submissionStartTime', 'submissionEndTime']),
      adjustmentStartTime: {
        get () {
          return this.$store.state.ShiftAdjustment.adjustmentStartTime
        },
        set (value) {
          this.$store.dispatch('updateAdjustmentStartTime', value)
        }
      },
      adjustmentEndTime: {
        get () {
          return this.$store.state.ShiftAdjustment.adjustmentEndTime
        },
        set (value) {
          this.$store.dispatch('updateAdjustmentEndTime', value)
        }
      }
    },
    data() {
      return {
        shiftSubmission: {
          id: document.getElementById('shift_adjustments_new').dataset.shift_submission_id
        }
      }
    },
    methods: {
      onSubmit() {
        this.$emit('onSubmit', this.shiftSubmission.id, this.$store.state.ShiftAdjustment)
      },
    },
    created () {
      this.$store.dispatch('loadShiftSubmission', this.shiftSubmission.id)
    }
  }
</script>

<style scoped>

</style>
