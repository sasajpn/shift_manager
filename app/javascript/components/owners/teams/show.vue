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
              v-if="findBy(member.shift_submissions, hour * 60 + minute)"
              v-bind:style="{ backgroundColor: 'black' }"
              colspan="1" rowspan="1">
            </td>
            <td v-else colspan="1" rowspan="1">{{ hour * 60 + minute }}</td>
          </template>
        </template>
      </tr>
    </tbody>
  </table>
</template>

<script>
  import { chart } from 'api/owners/teams.js'
  import { forEach, find, inRange } from 'lodash'
  export default {
    data() {
      return {
        tableColumns: {
          hours: [10, 11, 12],
          minutes: [0, 10, 20, 30, 40, 50]
        },
        team: {
          id: document.getElementById('teams_show').dataset.team_id
        },
        members: ''
      }
    },
    methods: {
      findBy(shift_submissions, time) {
        return find(shift_submissions, function(shiftSubmission) {
          return time >= shiftSubmission.start_time && time <= shiftSubmission.end_time
        })
      }
    },
    created () {
      chart(this.team.id).then((res) => {
        this.members = res.members
      })
    }
  }
</script>
