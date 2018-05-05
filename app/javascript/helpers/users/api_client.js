import axios from 'axios'

axios.defaults.baseURL = 'http://localhost:5000/api/v1/users'
axios.defaults.headers = {
}

export default (params = {}) => {
  return axios(params)
    .then(response => {
      return response.data
    })
    .catch(error => {
      throw error.response.data
    })
}
