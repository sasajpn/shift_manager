import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.baseURL = 'http://localhost:5000/api/v1/users/'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default (params = {}) => {
  return axios(params)
    .then(response => {
      return response.data
    })
    .catch(error => {
      throw error.response.data
    })
}
