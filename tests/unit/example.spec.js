import { shallowMount } from '@vue/test-utils'
import Pagos from '@/components/Pagos.vue'

describe('Pagos.vue', () => {
  it('renders props.msg when passed', () => {
    const msg = 'new message'
    const wrapper = shallowMount(Pagos, {
      props: { msg }
    })
    expect(wrapper.text()).toMatch(msg)
  })
})
