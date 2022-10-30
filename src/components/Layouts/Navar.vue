<template>
  <nav class="flex justify-between items-center bg-gray-700 text-sm px-8">
    <div class="flex px-5 py-4">
      <div class="ml-2 px-3 mobile-menu text-white"> |        
        <router-link to="/" class="px-2 hover:text-green-400">Clientes</router-link> |
        <router-link to="/pagos" class="px-2 hover:text-green-400">Pagos</router-link> |
      </div>
    </div>
  </nav>
</template>

<script>
export default {
    name: 'Navar'
}
</script>