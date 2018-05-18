<template>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th colspan="1" rowspan="2">名前</th>
        <th colspan="6" rowspan="1" v-for="hour in tableColumns.hours">{{ hour }}時</th>
      </tr>
      <tr>
        <template v-for="hour in tableColumns.hours">
          <th colspan="1" rowspan="1" v-for="minute in tableColumns.minutes" v-bind:data-time="hour + ':' + minute">{{ minute }}</th>
        </template>
      </tr>
    </thead>
    <tbody>
      <tr v-for="member in members">
        <td>{{ member.name }}</td>
        <template v-for="hour in tableColumns.hours">
          <template v-for="minute in tableColumns.minutes">
            <td
              v-if="findBy(member.shift_submissions, hour + ':' + minute)"
              v-bind:style="{ backgroundColor: 'black' }"
              :colspan="doColSpan(member.shift_submissions, hour + ':' + minute)" rowspan="1"
              >
            </td>
            <td v-else colspan="1" rowspan="1"></td>
          </template>
        </template>
      </tr>
    </tbody>
  </table>
</template>

<script>
  import { chart } from 'api/owners/teams.js'
  import { find } from 'lodash'
  export default {
    data() {
      return {
        tableColumns: {
          hours: ['10', '11', '12'],
          minutes: ['00', '10', '20', '30', '40', '50']
        },
        team: {
          id: document.getElementById('teams_show').dataset.team_id
        },
        members: ''
      }
    },
    methods: {
      findBy(shift_submissions, startTime) {
        return find(shift_submissions, { 'start_time': startTime })
      },
      doColSpan(shift_submissions, startTime) {
        return this.findBy(shift_submissions, startTime).colSpan
      }
    },
    created () {
      chart(this.team.id).then((res) => {
        this.members = res.members
        console.log(find(this.members[0].shift_submissions, { 'start_time': '10:00' }))
        console.log(this.findBy(this.members[0].shift_submissions, '10:00'))
      })
    }
  }
</script>
