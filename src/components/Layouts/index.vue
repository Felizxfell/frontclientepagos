<template>
  <div class="grid justify-items-stretch">
    <h1 class="text-gray-900 text-center uppercase decoration-from-font text-xl">
      {{ titulo }}
    </h1>
  </div>
  <div class="grid grid-flow-row auto-rows-max flex justify-center">    
    <slot name="clientes"></slot>
    <slot name="pagos"></slot>
  </div>
</template>

<script>
import { computed } from "vue";

export default {
  name: "Layout",
  props: {
    titulo: String,
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