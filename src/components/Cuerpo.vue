<template>
  <div class="grid justify-items-stretch">
    <h1 class="text-gray-900 text-center uppercase decoration-from-font text-xl">
      {{ titulo }}
    </h1>
  </div>
  <div class="grid grid-flow-row auto-rows-max flex justify-center">
    <FormCliente v-if="viewop" />
    <FormPago v-else />
  </div>
</template>

<script>
import FormCliente from "@/components/FormCliente.vue";
import FormPago from "@/components/FormPago.vue";

import { computed } from "vue";

export default {
  name: "Cuerpo",
  props: {
    titulo: String,
  },
  components: {
    FormCliente,
    FormPago,
  },
  setup(props) {
    const viewop = computed(() => {
      return props.titulo === "Clientes" ? true : false;
    });

    return {
      viewop,
    };
  },
};
</script>