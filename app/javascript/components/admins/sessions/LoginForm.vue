<template>
  <p>テスト</p>
  <el-form :model="loginForm" status-icon :rules="rules" ref="loginForm" label-width="120px" class="demo-ruleForm">
    <el-form-item label="メールアドレス" prop="email">
      <el-input type="email" v-model="loginForm.email" auto-complete="off"></el-input>
    </el-form-item>
    <el-form-item label="パスワード" prop="password">
      <el-input type="password" v-model="loginForm.password" auto-complete="off"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click.native="submitForm('loginForm')">ログイン</el-button>
      <el-button @click.native="resetForm('loginForm')">取り消し</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
  export default {
    name: 'login-form'
  }
</script>
