<template>
  <div>
    <error-messages :errorMessages='this.form.errorMessages'></error-messages>
    <el-form
      :model="team"
      label-width="140px">
      <el-form-item label="会社名" required>
        <el-input
          name="team[name]"
          v-model="team.name"
          placeholder="会社名を入力してください">
        </el-input>
      </el-form-item>
      <el-form-item label="営業時間">
        <el-form-item label="開始時間" required>
          <el-time-select
            placeholder="開始時間"
            name="team[open_time]"
            v-model="team.openTime"
            :picker-options="{
              start: '00:00',
              step: '00:10',
              end: '36:00'
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item label="終了時間" required>
          <el-time-select
            placeholder="終了時刻"
            name="team[close_time]"
            v-model="team.closeTime"
            :picker-options="{
              start: '00:00',
              step: '00:10',
              end: '36:00',
              minTime: team.openTime
            }">
          </el-time-select>
        </el-form-item>
        <el-form-item label="有効期限">
          <el-date-picker
            v-model="team.active_until"
            type="date"
            placeholder="有効期限を選択してください"
            :picker-options="pickerOptions">
          </el-date-picker>
        </el-form-item>
      </el-form-item>
      <el-form-item label="登録可能従業員数">
        <el-input-number
          v-model="team.maxMemberCount"
          controls-position="right"
          :min="0"></el-input-number>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">更新</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import {getTeam, updateTeam} from 'api/admins/teams.js'
  import ErrorMessages from 'components/shared/error_messages.vue'

  export default {
    components: {
      ErrorMessages
    },
    data() {
      return {
        pickerOptions: {
          disabledDate(time) {
            return time.getTime() < Date.now();
          },
          shortcuts: [{
            text: '1ヵ月後',
            onClick(picker) {
              const date = new Date();
              date.setMonth(date.getMonth() + 1);
              picker.$emit('pick', date);
            }
          }]
        },
        team: {
          id: document.getElementById('teams_edit').dataset.team_id,
          name: '',
          openTime: '',
          closeTime: '',
          active_until: null,
          maxMemberCount: ''
        },
        form: {
          errorMessages: []
        }
      }
    },
    methods: {
      onSubmit() {
        updateTeam(this.team).then((res) => {
          switch (res.status) {
            case '200':
              window.location.href = '/admins/teams/' + this.team.id
              break;
            case '400':
              this.form.errorMessages = res.error_messages
              break;
          }
        })
      }
    },
    created() {
      getTeam(this.team.id).then((res) => {
        this.team.name = res.name
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
        this.team.active_until = res.active_until
        this.team.maxMemberCount = res.max_member_count
      })
    }
  }
</script>

<style scoped>

</style>
