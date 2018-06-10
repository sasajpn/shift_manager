<template>
  <div class="shift-table">
    <table
      v-if="members.length !== 0"
      class="table table-bordered">
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
      <tbody v-for="member in members">
        <tr>
          <td rowspan="2" style="white-space: nowrap">{{ member.name }}</td>
          <template v-for="(min_of_days, hour) in team.business_hours">
            <template v-for="min_of_day in min_of_days">
              <td
                v-if="findBy(member.shifts, min_of_day)"
                v-bind:style="{ backgroundColor: '#303133' }"
                colspan="1" rowspan="1">
              </td>
              <td v-else colspan="1" rowspan="1"></td>
            </template>
          </template>
        </tr>
        <tr>
          <template v-for="(min_of_days, hour) in team.business_hours">
            <template v-for="min_of_day in min_of_days">
              <td
                v-if="findBy(member.shift_submissions, min_of_day)"
                v-bind:style="{ backgroundColor: '#909399', opacity: '0.6' }"
                colspan="1" rowspan="1">
              </td>
              <td v-else colspan="1" rowspan="1"></td>
            </template>
          </template>
        </tr>
      </tbody>
    </table>
    <div v-else class="callout callout-danger" v-cloak>
      <p>データがありません</p>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import { getShiftTable } from 'api/owners/shift_tables.js'
  import { find, padStart } from 'lodash'

  export default {
    computed: {
      ...mapGetters(['currentDate', 'formattedDate'])
    },
    data() {
      return {
        team: {
          id: document.getElementById('shift_tables').dataset.team_id,
          business_hours: {},
          shiftInCounts: []
        },
        members: []
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
        getShiftTable(this.team.id, this.formattedDate).then((res) => {
          this.members = res.members
        })
      }
    },
    created () {
      getShiftTable(this.team.id, this.formattedDate).then((res) => {
        this.team.business_hours = res.team.business_hours
        this.team.shiftInCounts = res.team.shift_in_counts
        this.members = res.members
      })
    }
  }
</script>

<style scoped>
  [v-cloak] {
    display:none;
  }

  .shift-table {
    max-height: 500px;
    overflow-x: auto;
  }

  .shift-table tr, .shift-table th, .shift-table td {
    text-align: center;
    vertical-align: middle;
    height: 30px;
    width: 30px;
  }

  .table>tbody+tbody {
    border-top: 2px solid #000000;
  }
</style>
