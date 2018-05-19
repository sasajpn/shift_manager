<template>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th colspan="1" rowspan="2">名前</th>
        <th colspan="6" rowspan="1" v-for="(min_of_days, hour) in team.business_hours">{{ hour }}時</th>
      </tr>
      <tr>
        <template v-for="(min_of_days, hour) in team.business_hours">
          <th colspan="1" rowspan="1" v-for="min_of_day in min_of_days">{{ calcMinute(min_of_day) }}</th>
        </template>
      </tr>
    </thead>
    <tbody>
      <tr v-for="member in members">
        <td style="white-space: nowrap">{{ member.name }}</td>
        <template v-for="(min_of_days, hour) in team.business_hours">
          <template v-for="min_of_day in min_of_days">
            <td
              v-if="findBy(member.shift_submissions, min_of_day)"
              v-bind:style="{ backgroundColor: 'black' }"
              colspan="1" rowspan="1">
            </td>
            <td v-else colspan="1" rowspan="1"></td>
          </template>
        </template>
      </tr>
    </tbody>
  </table>
</template>

<script>
  import { mapGetters } from 'vuex'
  import { indexShiftTable } from 'api/owners/shift_tables.js'
  import { find, padStart } from 'lodash'
  export default {
    computed: {
      ...mapGetters(['currentDate', 'formattedDate'])
    },
    data() {
      return {
        team: {
          id: document.getElementById('shift_tables').dataset.team_id,
          business_hours: ''
        },
        members: ''
      }
    },
    methods: {
      findBy(shift_submissions, min_of_day) {
        return find(shift_submissions, function(shiftSubmission) {
          return min_of_day >= shiftSubmission.start_time && min_of_day <= shiftSubmission.end_time
        })
      },
      calcMinute(min_of_day) {
        return padStart(min_of_day % 60, 2, 0)
      }
    },
    watch: {
      formattedDate: function (newFormattedDate) {
        indexShiftTable(this.team.id, this.formattedDate).then((res) => {
          this.members = res.members
        })
      }
    },
    created () {
      indexShiftTable(this.team.id, this.formattedDate).then((res) => {
        this.team.business_hours = res.team.business_hours
        this.members = res.members
      })
    }
  }
</script>
