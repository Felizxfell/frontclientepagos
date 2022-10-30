<template>
  <Navar />
  <div class="container-lg p-4 h-full bg-white font-mono">
    <router-view />
  </div>
</template>

<script>
import Navar from '@/components/Layouts/Navar.vue';

export default {
  components: {
    Navar
  }
}
</script>
