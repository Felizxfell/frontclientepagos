<template>
  <Layout titulo="Clientes">
    <template #clientes>
      <div class="my-10">
        <form @submit.prevent="submit">
          <div class="shadow overflow-hidden sm:rounded-md">
            <div class="px-4 py-5 bg-white sm:p-6">
              <div class="grid grid-cols-6 gap-6">
                <div class="col-span-6 sm:col-span-3">
                  <label for="nombre" class="block text-sm text-gray-700"
                    >Nombre</label
                  >
                  <input
                    type="text"
                    v-model.trim="nombre"
                    id="nombre"
                    autocomplete="off"
                    class="mt-1 block w-full shadow-sm sm:text-sm border-gray-700 rounded-md"
                  />
                </div>
                <div class="col-span-6 sm:col-span-3">
                  <label for="telefono" class="block text-sm text-gray-700"
                    >Telefono</label
                  >
                  <input
                    type="text"
                    v-model.trim="telefono"
                    id="telefono"
                    autocomplete="off"
                    class="mt-1 block w-full shadow-sm sm:text-sm border-gray-700 rounded-md"
                  />
                </div>
              </div>
            </div>
            <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
              <button
                type="submit"
                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none"
              >
                Save
              </button>
            </div>
          </div>
        </form>
      </div>

      <div class="relative overflow-x-auto sm:rounded-lg">
        <ListaClientes />
      </div>
    </template>
  </Layout>
</template>

<script>
import { ref } from "vue";
import { useStore } from "vuex";
import Layout from "@/components/Layouts/";
import ListaClientes from "./ListaClientes.vue";
import { UrlsApi } from "@/utils/";

const { URLAPI_CLIENTES } = UrlsApi();

export default {
  name: "index",
  components: {
    Layout,
    ListaClientes
  },
  setup() {
    const store = useStore();

    const nombre = ref("");
    const telefono = ref("");    

    const submit = async () => {
      if (nombre.value !== "" && telefono.value !== "") {
        try {
          const data = {
            nombre: nombre.value,
            telefono: telefono.value,
            ultimoPago: null,
          };
          const reqs = await fetch(`${URLAPI_CLIENTES}`, {
            body: JSON.stringify(data),
            method: "post",
            headers: {
              "Content-Type": "application/json",
            },
          });
          const resp = await reqs.json();
          console.log(resp);
        } catch (error) {
          throw new Error(error);
        } finally {
          limpiarFormulario();
        }
      }
    };

    const limpiarFormulario = () => {
      nombre.value = "";
      telefono.value = "";
      store.dispatch("listarClientesAsync");
    };

    return {
      nombre,
      telefono,
      submit,      
    };
  },
};
</script>

<style scoped>
.click {
  cursor: pointer;
}
</style>
