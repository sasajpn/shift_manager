<template>
  <div>
    <el-form
      :model="form"
      :action="form.action"
      method="post"
      label-width="120px">
      <input type="hidden" name="_method" value="patch" />
      <csrf></csrf>
      <el-form-item label="会社名" required>
        <el-input
          name="team[name]"
          v-model="team.name"
          placeholder="会社名を入力してください">
        </el-input>
      </el-form-item>
      <el-form-item label="営業時間" required>
        <el-col :span="11">
          <el-form-item>
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
        </el-col>
        <el-col :span="11">
          <el-form-item>
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
        </el-col>
      </el-form-item>
      <el-form-item>
        <el-button native-type="submit" type="primary">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { editTeam } from 'api/admins/teams.js'
  import CSRF from 'components/shared/csrf.vue';

  export default {
    components: {
      csrf: CSRF
    },
    data() {
      return {
        team: {
          id: document.getElementById('teams_edit').dataset.team_id,
          name: '',
          openTime: '',
          endTime: ''
        },
        form: {
          action: ''
        }
      }
    },
    created () {
      editTeam(this.team.id).then((res) => {
        this.team.name = res.name
        this.team.openTime = res.open_time
        this.team.closeTime = res.close_time
      })
      this.form.action = '/admins/teams/' + this.team.id
    }
  }
</script>

<style scoped>

</style>
