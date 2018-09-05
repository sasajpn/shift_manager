<template>
  <div>
    <shift-table-header></shift-table-header>
    <shift-table-main></shift-table-main>
  </div>
</template>

<script>
  import ShiftTableHeader from './ShiftTableHeader'
  import ShiftTableMain from './ShiftTableMain'

  export default {
    components: {
      ShiftTableHeader,
      ShiftTableMain
    }
  }

</script>
